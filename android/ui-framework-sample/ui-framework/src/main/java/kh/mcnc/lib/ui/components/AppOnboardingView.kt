package kh.mcnc.lib.ui.components

import android.content.Context
import android.util.AttributeSet
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.compose.ui.platform.AbstractComposeView

class AppOnboardingView @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : AbstractComposeView(context, attrs, defStyleAttr) {

    private var onboardingPages by mutableStateOf<List<OnboardingPageData>>(emptyList())
    private var onFinishListener: (() -> Unit)? = null
    private var onSkipListener: (() -> Unit)? = null

    /**
     * Sets the data for the onboarding pages.
     */
    fun setPages(pages: List<OnboardingPageData>) {
        this.onboardingPages = pages
    }

    /**
     * Sets the listener for when the user clicks the "Get Started" / Finish button on the last page.
     */
    fun setOnFinishListener(listener: () -> Unit) {
        this.onFinishListener = listener
    }

    /**
     * Sets the listener for when the user clicks the "Skip" button.
     */
    fun setOnSkipListener(listener: () -> Unit) {
        this.onSkipListener = listener
    }

    @Composable
    override fun Content() {
        AppOnboarding(
            pages = onboardingPages,
            onFinish = { onFinishListener?.invoke() },
            onSkip = { onSkipListener?.invoke() }
        )
    }
}
