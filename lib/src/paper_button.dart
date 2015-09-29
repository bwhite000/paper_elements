part of PaperElements.lib.paperElements;

class PaperButton extends PaperFocusable {
  /**
   * Shadow root for the custom element.
   */
  ShadowRoot shadowRoot;

  SpanElement labelElm;

  /// The label of the button.
  String _label = '';

  /// If true, the button will be styled as a "raised" button.
  bool raisedButton = false;

  /**
   * (optional) The URL of an image for an icon to use in the button.
   * Should not use 'icon' property if you are using this property.
   */
  String iconSrc = '';

  /**
   * (optional) Specifies the icon name or index in the set of icons
   * available in the icon set. If using this property, load the icon
   * set separately where the icon is used. Should not use 'iconSrc'
   * if your are using this property.
   */
  String icon = '';

  int z = 1;
  dynamic lastEvent;

  PaperButton.created() : super.created() {
    final DocumentFragment frag = ((querySelector(r'link[rel="import"][href$="/paper_elements/paper_button.html"]') as LinkElement).import
        .querySelector('#template_paper-button') as TemplateElement).content.clone(true);

    this.disabled = this.attributes.containsKey('disabled') ? true : false;

    // Create the shadow root for templating
    shadowRoot = this.createShadowRoot();

    frag.append(new Element.tag('paper-ripple'));

    /*
     * Convert the contents of the custom element
     */
    this.convertLabel(frag);
    this.convertRaised();

    // Append the modified shadow root to the host element
    shadowRoot.append(frag);

    this.label = this.attributes['label'];

    this.onMouseDown.listen((final MouseEvent event) {
      if (this.disabled) {
        return;
      }

      (this.shadowRoot.querySelector('paper-ripple') as PaperRipple).play(event);

      if (this.raisedButton) {
        this.classes.add('paper-shadow-z-2');
      }
    });

    this.onMouseUp.listen((final MouseEvent event) {
      if (this.raisedButton) {
        this.classes.remove('paper-shadow-z-2');
      }
    });
  }

  // Getters
  String get label {
    return this._label;
  }

  // Setters
  void set label(final String str) {
    this._label = str;

    if (labelElm != null) {
      labelElm.text = str;
    }
  }

  // Util
  @override
  void attached() {
    super.attached();

    if (this.text.isNotEmpty) {
      window.console.warn('Using .text to label the button is deprecated. Use the "label" property instead.');
      this.label = this.text;
    }
  }

  /*
  void activeChanged() {
    if (this.active) {
      // FIXME: Remove when paper-ripple can have a default 'down' state
      if (this.lastEvent == false) {
        var rect = this.getBoundingClientRect();
        this.lastEvent = {
          'x': rect.left + rect.width / 2,
          'y': rect.top + rect.height / 2
        };
      }

      //this.$.ripple.downAction();
    } else {
      //this.$.ripple.upAction();
    }

    this.adjustZ();
  }
  */

  //void focusChanged() {}

  //void disabledChanged() {}

  //void insideButton() {}

  //void adjustZ() {}

  /*
  void downAction([final Event event]) {
    super.downAction(event);
    this.lastEvent = event;
  }
  */

  void labelChanged() {
    this.setAttribute('aria-label', this.label);
  }

  void convertLabel(final DocumentFragment frag) {
    //if (this.attributes.containsKey('label')) {
      final DocumentFragment labelFrag = (frag.querySelector('template[if*="label"]') as TemplateElement).content;
      frag.querySelector('#content').append(labelFrag);

      this.labelElm = frag.querySelector('#content > .label') as SpanElement;
    //}
  }

  void convertRaised() {
    if (this.attributes.containsKey('raisedButton') && this.disabled == false) {
      this.classes.add('paper-shadow-bottom-z-1');
      this.classes.add('paper-shadow-top-z-1');
    }
  }
}