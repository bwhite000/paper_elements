part of PaperElements.lib.paperElements;

class PaperIconButton extends HtmlElement {
  ShadowRoot _shadowRoot;
  String _iconName;
  DivElement _contentElm;

  PaperIconButton.created() : super.created() {
    final LinkElement linkElm = querySelector(r'link[rel="import"][href$="/paper_elements/paper_icon_button.html"]') as LinkElement;

    if (linkElm == null) {
      throw new Exception('The required HTML import for PaperIconButton was not found in the DOM.');
    }

    final TemplateElement templateElm = linkElm.import.querySelector('#template_paper-icon-button') as TemplateElement;
    final DocumentFragment frag = templateElm.content.clone(true) as DocumentFragment;

    this._shadowRoot = this.createShadowRoot();
    this._shadowRoot.append(frag);
    this._contentElm = this._shadowRoot.querySelector('#content');

    if (this.attributes.containsKey('icon')) {
      final CoreElements.CoreIcon coreIcon = new Element.tag('core-icon');
      this._iconName = this.attributes['icon'];
      coreIcon.icon = this._iconName;
      this._contentElm.append(coreIcon);
    }
  }
}