import { createVNode, render, Component, ref, watch } from 'vue';

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
    document.body.appendChild(container);

    let isRemoving = false;

    const removeContainer = () => {
      if (isRemoving) return;
      isRemoving = true;
      // Wait for exit animations (like bottom sheet sliding down)
      setTimeout(() => {
        render(null, container);
        container.remove();
      }, 300); 
    };

    // Reactive reference to control the visibility (modelValue)
    const modelValueRef = ref(true);

    const renderComponent = () => {
      const vnodeProps = {
        ...props,
        modelValue: modelValueRef.value,
        'onUpdate:modelValue': (val: boolean) => {
          modelValueRef.value = val;
          // Trigger the original onUpdate:modelValue if provided
          if (props['onUpdate:modelValue']) {
            props['onUpdate:modelValue'](val);
          }
          // If the component emits false, we remove it
          if (!val) {
            removeContainer();
          }
        }
      };

      const vnode = createVNode(component, vnodeProps);
      render(vnode, container);
    };

    // Initial render
    renderComponent();

    // Watch for changes to modelValueRef to re-render and remove
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
}
