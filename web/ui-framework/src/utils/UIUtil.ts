import { createVNode, render, Component, ref, nextTick, watch } from 'vue';

/**
 * A utility class to imperatively show Vue components like BottomSheets, Dialogs, etc.
 * without needing to declare them in the template.
 */
export class UIUtil {
  /**
   * Dynamically mounts a Vue component to the body.
   * Useful for BottomSheets, Dialogs, and Dynamic Islands.
   * 
   * @param component The Vue component to render (e.g., PPConfirmSheet)
   * @param props The props to pass to the component
   * @returns An object with a `close` method to programmatically close the component
   */
  static showComponent(component: Component, props: Record<string, any> = {}) {
    const container = document.createElement('div');
    
    // Inherit theme from the main app container if present
    const appEl = document.querySelector('.pp-material-app');
    if (appEl && appEl.classList.contains('dark')) {
      container.classList.add('pp-material-app', 'dark');
      if (props.theme === undefined) {
        props.theme = 'dark';
      }
    }
    
    document.body.appendChild(container);

    let isRemoving = false;

    const removeContainer = () => {
      if (isRemoving) return;
      isRemoving = true;
      // Wait for exit animations
      setTimeout(() => {
        render(null, container);
        container.remove();
      }, 300); 
    };

    // Start with false to trigger enter animations
    const modelValueRef = ref(false);

    const renderComponent = () => {
      const vnodeProps = {
        ...props,
        modelValue: modelValueRef.value,
        'onUpdate:modelValue': (val: boolean) => {
          modelValueRef.value = val;
          if (props['onUpdate:modelValue']) {
            props['onUpdate:modelValue'](val);
          }
          if (!val) {
            removeContainer();
          }
        }
      };

      const vnode = createVNode(component, vnodeProps);
      render(vnode, container);
    };

    // Initial render with modelValue: false
    renderComponent();
    
    // Trigger enter animation on the next tick
    nextTick(() => {
      modelValueRef.value = true;
    });

    watch(modelValueRef, (newVal) => {
      renderComponent();
      if (!newVal && !isRemoving) {
        removeContainer();
      }
    });

    return {
      close: () => {
        modelValueRef.value = false;
      }
    };
  }

  /**
   * Shows a Dialog component
   */
  static showDialog(component: Component, props: Record<string, any> = {}) {
    return this.showComponent(component, props);
  }

  /**
   * Shows a Dynamic Island component
   */
  static showDynamicIsland(component: Component, props: Record<string, any> = {}) {
    return this.showComponent(component, props);
  }

  /**
   * Shows a Bottom Sheet component
   */
  static showBottomSheet(component: Component, props: Record<string, any> = {}) {
    return this.showComponent(component, props);
  }
}
