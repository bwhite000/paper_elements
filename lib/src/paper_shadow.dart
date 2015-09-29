part of PaperElements.lib.paperElements;

class PaperShadow extends HtmlElement {
  ShadowRoot _shadowRoot;
  int _z;

  PaperShadow.created() : super.created() {
    final LinkElement linkElm = querySelector(r'link[rel="import"][href$="/paper_elements/paper_shadow.html"]') as LinkElement;

    if (linkElm == null) {
      throw new Exception('The required HTML import for PaperShadow was not found in the DOM.');
    }

    final TemplateElement templateElm = linkElm.import.querySelector('#template_paper-shadow') as TemplateElement;
    final DocumentFragment frag = templateElm.content.clone(true) as DocumentFragment;

    this._shadowRoot = this.createShadowRoot();
    this._shadowRoot.append(frag);

    if (this.attributes.containsKey('z')) {
      if (new RegExp(r'^[0-5]$').hasMatch(this.attributes['z'])) {
        this.z = int.parse(this.attributes['z']);
      } else {
        window.console.error('The [z] attribute must be an integer ranging between 0-5.');
      }
    }
  }

  // Getter
  int get z {
    return this._z;
  }

  // Setters
  void set z(final int zLevel) {
    this._z = zLevel;

    switch(zLevel) {
      case 1:
        this._shadowRoot
            ..querySelector('#bottom_shadow').classes.add('bottom-z-0')
            ..querySelector('#top_shadow').classes.add('top-z-0');
        break;

      case 1:
        this._shadowRoot
            ..querySelector('#bottom_shadow').classes.add('bottom-z-1')
            ..querySelector('#top_shadow').classes.add('top-z-1');
        break;

      case 2:
        this._shadowRoot
            ..querySelector('#bottom_shadow').classes.add('bottom-z-2')
            ..querySelector('#top_shadow').classes.add('top-z-2');
        break;

      case 3:
        this._shadowRoot
            ..querySelector('#bottom_shadow').classes.add('bottom-z-3')
            ..querySelector('#top_shadow').classes.add('top-z-3');
        break;

      case 4:
        this._shadowRoot
            ..querySelector('#bottom_shadow').classes.add('bottom-z-4')
            ..querySelector('#top_shadow').classes.add('top-z-4');
        break;

      case 5:
        this._shadowRoot
            ..querySelector('#bottom_shadow').classes.add('bottom-z-5')
            ..querySelector('#top_shadow').classes.add('top-z-5');
        break;
    }
  }
}