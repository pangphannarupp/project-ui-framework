package kh.mcnc.lib.ui

import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import kh.mcnc.lib.R

data class ComponentItem(val title: String, val category: String)

class ComponentListActivity : AppCompatActivity() {

    private lateinit var recyclerView: RecyclerView
    private lateinit var etSearch: EditText
    private lateinit var adapter: ComponentAdapter

    private val allItems = listOf(
        ComponentItem("Buttons", "Basic"),
        ComponentItem("Text Fields", "Basic"),
        ComponentItem("Khmer Calendar (Dynamic Rows)", "Calendar"),
        ComponentItem("Khmer Calendar (Range Select)", "Calendar"),
        ComponentItem("Currency Input", "Inputs"),
        ComponentItem("Progress Stepper", "Navigation"),
        ComponentItem("Searchable Bottom Sheet", "Sheets"),
        ComponentItem("Expandable Accordion", "Layout"),
        ComponentItem("Swipe-to-Action Item", "Lists"),
        ComponentItem("Custom Snackbar", "Feedback"),
        ComponentItem("File Uploader", "Media"),
        ComponentItem("Timeline View", "Data"),
        ComponentItem("OTP Input", "Inputs"),
        ComponentItem("Skeleton Loading", "Feedback"),
        ComponentItem("Data Table", "Data"),
        ComponentItem("Range Slider", "Inputs"),
        ComponentItem("Digital Signature Pad", "Media"),
        ComponentItem("Interactive Line Chart", "Data"),
        ComponentItem("Document Scanner Viewfinder", "Media"),
        ComponentItem("Expandable FAB Menu", "Navigation"),
        ComponentItem("Circular Progress / Donut", "Data"),
        ComponentItem("PDF Viewer Wrapper", "Media"),
        ComponentItem("Currency Keypad", "Inputs"),
        ComponentItem("Passcode Lock Screen", "Security"),
        ComponentItem("Interactive Card Carousel", "Lists"),
        ComponentItem("Loan Comparison Table", "Data"),
        ComponentItem("Interactive Scratch Card", "Gamification"),
        ComponentItem("Biometric Prompt Overlay", "Security"),
        ComponentItem("Draggable Grid Dashboard", "Layout"),
        ComponentItem("Pulsing Radar Animation", "Feedback"),
        ComponentItem("Assistive Floating Menu", "Navigation"),
        ComponentItem("Animated Rating Bar", "Inputs"),
        ComponentItem("Custom Video Player Wrapper", "Media"),
        ComponentItem("Confetti Particle System", "Gamification"),
        ComponentItem("Gauge / Speedometer Chart", "Data"),
        ComponentItem("Rich Text Editor UI", "Inputs"),
        ComponentItem("Scrolling Stock Ticker", "Data"),
        ComponentItem("Hierarchical Tree Selector", "Sheets"),
        ComponentItem("Data Heat Map (Activity)", "Data"),
        ComponentItem("Animated Network Status", "Feedback"),
        ComponentItem("ID/Document Camera Capture UI", "Media"),
        ComponentItem("3D Credit Card Flip", "Gamification"),
        ComponentItem("Animated Audio Recorder", "Media"),
        ComponentItem("Document Cropper UI", "Media"),
        ComponentItem("Custom Pull-to-Refresh Indicator", "Feedback"),
        ComponentItem("Approval Line UI", "Data"),
        ComponentItem("Profile UI", "Layout"),
        ComponentItem("Onboarding UI", "Navigation"),
        ComponentItem("Branch Locator Feature", "Layout"),
        ComponentItem("Date Picker Bottom Sheet", "Sheets"),
        ComponentItem("PIN Entry Screen", "Security")
    )

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_component_list)

        recyclerView = findViewById(R.id.recyclerView)
        etSearch = findViewById(R.id.etSearch)

        recyclerView.layoutManager = LinearLayoutManager(this)
        adapter = ComponentAdapter(allItems) { item ->
            val intent = Intent(this, ComponentDetailActivity::class.java).apply {
                putExtra("COMPONENT_NAME", item.title)
            }
            startActivity(intent)
        }
        recyclerView.adapter = adapter

        etSearch.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                val query = s?.toString()?.lowercase() ?: ""
                val filtered = if (query.isEmpty()) {
                    allItems
                } else {
                    allItems.filter { it.title.lowercase().contains(query) || it.category.lowercase().contains(query) }
                }
                adapter.updateData(filtered)
            }
            override fun afterTextChanged(s: Editable?) {}
        })
    }

    class ComponentAdapter(
        private var items: List<ComponentItem>,
        private val onItemClick: (ComponentItem) -> Unit
    ) : RecyclerView.Adapter<ComponentAdapter.ViewHolder>() {

        class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
            val tvTitle: TextView = view.findViewById(R.id.tvTitle)
            val tvCategory: TextView = view.findViewById(R.id.tvCategory)
        }

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
            val view = LayoutInflater.from(parent.context)
                .inflate(R.layout.item_component, parent, false)
            return ViewHolder(view)
        }

        override fun onBindViewHolder(holder: ViewHolder, position: Int) {
            val item = items[position]
            holder.tvTitle.text = item.title
            holder.tvCategory.text = item.category
            holder.itemView.setOnClickListener { onItemClick(item) }
        }

        override fun getItemCount() = items.size

        fun updateData(newItems: List<ComponentItem>) {
            items = newItems
            notifyDataSetChanged()
        }
    }
}
