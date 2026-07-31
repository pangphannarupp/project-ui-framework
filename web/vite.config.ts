/// <reference types="vitest" />
import vue from "@vitejs/plugin-vue";
import fs from "node:fs";
import http, { IncomingMessage } from "node:http";
import https from "node:https";
import path from "node:path";
import { defineConfig, loadEnv, Plugin } from "vite";

// https://vitejs.dev/config/

export default defineConfig(({ mode }) => {
	Object.keys(loadEnv(mode, process.cwd(), "")).forEach((key: string) => {
		if (key.startsWith("VITE_")) {
			process.env[key] = loadEnv(mode, process.cwd(), "")[key];
		}
	});
	return {
		base: process.env.VITE_ENVIRONMENT === 'production' ? '/project-ui-framework/' : '/',
		plugins: [
			dynamicSubdomainProxy(),
			vue(),
			{
				name: "selective-copy-assets",
				apply: "build",
				async generateBundle() {
					const publicDir = path.resolve(__dirname, "src/assets");
					const outputDir = path.resolve(__dirname, `dist/${process.env.VITE_ENVIRONMENT}/contents`);

					// Define allowed folders/files to copy
					const allowedFolders = ["images"];

					for (const folderOrFile of allowedFolders) {
						const src = path.resolve(publicDir, folderOrFile);
						const dest = path.resolve(outputDir, folderOrFile);

						// Copy logic
						if (fs.existsSync(src)) {
							copyRecursiveSync(src, dest);
						}
					}
				}
			}
		],
		optimizeDeps: {
			exclude: ["swipe-back"]
		},
		css: {
			preprocessorOptions: {
				scss: {}
			}
		},
		resolve: {
			alias: {
				"@": path.resolve(__dirname, "./src"),
			},
		},
		server: {
			host: true,
			hmr: {
				overlay: true,
				timeout: Number.MAX_SAFE_INTEGER
			},
			port: 3000,
			// strictPort: true
		},
		preview: {
			host: true,
			hmr: {
				overlay: true,
				timeout: Number.MAX_SAFE_INTEGER
			},
			port: 4173,
			// strictPort: true
		},
		test: {
			globals: true,
			environment: "jsdom"
		},
		build: {
			emptyOutDir: true,
			outDir: `dist/${process.env.VITE_ENVIRONMENT}/contents`,
			chunkSizeWarningLimit: 3000,
			sourcemap: false,
			rollupOptions: {
				output: {
					/**
					 * ================================
					 * MANUAL CHUNKS
					 * ================================
					 */
					manualChunks(id: string) {
						// -------------------------------
						// 1️⃣ Vendors (split per package)
						// -------------------------------
						if (id.includes("node_modules")) {
							// const match = id.match(/node_modules[\\/](?:@([^\\/]+)[\\/])?([^\\/]+)/);
							// if (match) {
							// 	const scope = match[1];
							// 	const pkg = match[2];
							// 	return scope ? `vendor_${scope}_${pkg}` : `vendor_${pkg}`;
							// }
							return "vendor";
						}

						// -------------------------------
						// 2️⃣ All src/** modules
						// -------------------------------
						if (id.includes("/src/") || id.includes("\\src\\")) {
							const cleanId = id.split("?")[0];
							const parsed = path.parse(cleanId);

							/**
							 * 🔑 CRITICAL FIX:
							 * index.ts / index.vue / index.js
							 * → use parent folder name
							 */
							if (parsed.name === "index") {
								return path.basename(parsed.dir);
							}

							// Normal files → original name
							return parsed.name;
						}
					},

					/**
					 * ================================
					 * OUTPUT FILE NAMES
					 * ================================
					 */
					chunkFileNames(chunkInfo) {
						const safeName = (chunkInfo.name || "chunk")
							.replace(/[^a-zA-Z0-9_-]/g, "_");

						// Vendors
						if (safeName.startsWith("vendor")) {
							return `vendors/${safeName}-[hash].js`;
						}

						// 👉 All JS in /js (NO sub-folders)
						return `js/${safeName}-[hash].js`;
					},

					entryFileNames: "js/[name]-[hash].js",

					/**
					 * ================================
					 * ASSETS
					 * ================================
					 */
					assetFileNames(assetInfo) {
						// Get extension
						const name = assetInfo.name ?? "";
						const ext = name.split(".").pop();
						// Images
						if (/\.(png|jpe?g|gif|svg|webp|bmp|ico)$/i.test(name)) {
							return "images/[name][extname]";
						}
						// CSS
						if (ext === "css") {
							return "styles/[name][extname]";
						}

						return "[name][extname]";
					}
				}
			}
		},
	};
});
function copyRecursiveSync(src: any, dest: any) {
	const stats = fs.statSync(src);
	if (stats.isDirectory()) {
		fs.mkdirSync(dest, { recursive: true });
		for (const file of fs.readdirSync(src)) {
			copyRecursiveSync(path.join(src, file), path.join(dest, file));
		}
	} else {
		fs.mkdirSync(path.dirname(dest), { recursive: true });
		fs.copyFileSync(src, dest);
	}
}

/**
 * Vite plugin for dynamic subdomain-based proxy routing
 * Reads subdomain from request headers (X-Subdomain) or query params
 * and dynamically routes to the appropriate target URL
 * Uses only Node.js built-in modules (no external dependencies)
 */
function dynamicSubdomainProxy(): Plugin {
	const attach = (server: any) => {
		const getRawBody = (req: IncomingMessage): Promise<string> =>
			new Promise((resolve) => {
				const chunks: Buffer[] = [];
				req.on("data", chunk => chunks.push(chunk));
				req.on("end", () => resolve(Buffer.concat(chunks).toString("utf8")));
			});

		const toCurl = (
			method: string,
			url: string,
			headers: http.OutgoingHttpHeaders,
			body?: string
		) => {
			let curl = `curl -X ${method} "${url}"`;
			Object.entries(headers).forEach(([key, value]) => {
				if (!value) return;
				if (Array.isArray(value)) {
					value.forEach(v => { curl += ` \\\n  -H "${key}: ${v}"`; });
				} else {
					curl += ` \\\n  -H "${key}: ${value}"`;
				}
			});
			if (body) curl += ` \\\n  --data '${body.replace(/'/g, "'\\''")}'`;
			return curl;
		};

		server.middlewares.use(async (req: any, res: any, next: any) => {
			if (!req.url?.startsWith("/alias-server")) return next();
			try {
				const subdomain = req.headers["x-subdomain"]; // process.env.VITE_SERVER_SUB_DOMAIN;
				console.log("VITE_SERVER_SUB_DOMAIN => ", req.headers, req.headers["x-subdomain"]);
				const targetPath = req.url.replace(/^\/alias-server/, "");
				const protocol = process.env.VITE_SERVER_PROTOCOL || "https";
				const domain = process.env.VITE_SERVER_DOMAIN || "mcnc.com.kh";
				const hostname = subdomain ? `${subdomain}.${domain}` : domain;
				const baseUrl = `${protocol}://${hostname}${targetPath}`;
				const target = new URL(baseUrl);

				const proxyOptions: http.RequestOptions = {
					hostname: target.hostname,
					port: target.port || (target.protocol === "https:" ? 443 : 80),
					path: target.pathname + target.search,
					method: req.method,
					headers: {} as any
				};

				const hopByHopHeaders = ["connection", "keep-alive", "transfer-encoding", "upgrade", "proxy-authenticate", "proxy-authorization", "te", "trailer"];
				Object.keys(req.headers).forEach(key => {
					if (!hopByHopHeaders.includes(key.toLowerCase())) {
						(proxyOptions.headers as any)![key] = req.headers[key];
					}
				});
				(proxyOptions.headers as any)!["host"] = target.host;
				const client = target.protocol === "https:" ? https : http;

				let rawBody = "";
				const shouldPrint = process.env.VITE_ENVIRONMENT === "development" && process.env.VITE_PRINT_CURL === "true";
				if (shouldPrint) {
					rawBody = await getRawBody(req);
					const curl = toCurl(req.method || "GET", target.toString(), proxyOptions.headers as http.OutgoingHttpHeaders, rawBody);
					console.log("\n========== CURL ==========");
					console.log(curl);
					console.log("==========================\n");
				}

				const proxyReq = client.request(proxyOptions, proxyRes => {
					const responseHeaders: Record<string, string | string[]> = {};
					Object.keys(proxyRes.headers).forEach(key => {
						if (!hopByHopHeaders.includes(key.toLowerCase())) responseHeaders[key] = proxyRes.headers[key] as string | string[];
					});
					if (!res.headersSent) res.writeHead(proxyRes.statusCode || 200, responseHeaders);
					proxyRes.pipe(res);
				});

				proxyReq.on("error", err => {
					console.error("[Proxy Error]", err);
					if (!res.headersSent) { res.writeHead(502, { "Content-Type": "text/plain" }); res.end("Bad Gateway: " + err.message); }
				});
				req.on("aborted", () => proxyReq.destroy());
				res.on("close", () => proxyReq.destroy());

				if (rawBody) { proxyReq.write(rawBody); proxyReq.end(); } else { req.pipe(proxyReq); }
			} catch (err: any) {
				console.error("[Middleware Error]", err);
				if (!res.headersSent) { res.writeHead(500, { "Content-Type": "text/plain" }); res.end("Internal Server Error"); }
			}
		});
	};

	return {
		name: "dynamic-subdomain-proxy",
		configureServer(server) { attach(server); },
		configurePreviewServer(server) { attach(server); }
	};
}
