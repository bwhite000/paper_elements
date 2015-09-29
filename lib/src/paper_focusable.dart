part of PaperElements.lib.paperElements;

class PaperFocusable extends HtmlElement {
  /**
   * If true, the button is currently active either because the
   * user is holding down the button, or the button is a toggle
   * and is currently in the active state.
   */
  bool active = false;

  /**
   * If true, the element currently has focues due to keyboard
   * navigation.
   */
  bool focused = false;

  /**
   * If true, the user is currently holding down the button.
   */
  bool pressed = false;

  /**
   * If true, the user cannot interact with this element.
   */
  bool disabled = false;

  /**
   * If true, the button toggles the active state with each tap.
   * Otherwise, the button becomes active when the user is holding
   * it down.
   */
  bool isToggle = false;

  PaperFocusable.created() : super.created();

  void disableChanged () {
    if (this.disabled) {
      this.attributes.remove('tabindex');
    } else {
      this.attributes['tabindex'] = '0';
    }
  }

  void _downAction(final Event event) {
    if (this.disabled) {
      return;
    }

    this.downAction(event);
  }

  void downAction([final Event event]) {
    this.pressed = true;
    this.focused = false;

    if (this.isToggle) {
      this.active = !this.active;
    } else {
      this.active = true;
    }
  }

  /*
   * Pulling up the context menu for an item should focus it, but we need to
   * be careful about how we deal with down/up events surrounding context
   * menus. The up event typically does not fire until the context menu
   * closes, so we focus immediately.
   *
   * This fires _after_ downAction.
   */
  void contextMenuAction(final Event event) {
    if (this.disabled) {
      return;
    }

    // Note that upAction may fire _again_ on the actual up event.
    this.upAction(event);
    this.focusAction();
  }

  void _upAction(final Event event) {
    if (this.disabled) {
      return;
    }

    this.upAction(event);
  }

  void upAction([final Event event]) {
    this.pressed = false;

    if (this.isToggle == false) {
      this.active = false;
    }
  }

  void focusAction() {
    if (this.pressed == false) {
      // Only render the "focused" state if the element fains focus due to
      // keyboard navigation
      this.focused = true;
    }
  }

  void blurAction() {
    this.focused = false;
  }
}