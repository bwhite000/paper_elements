part of PaperElements.lib.paperElements;

class PaperToggleButton extends HtmlElement {
  ShadowRoot _shadowRoot;

  PaperToggleButton.created() : super.created() {
    final LinkElement linkElm = querySelector(r'link[rel="import"][href$="/paper_elements/paper_toggle_button.html"]') as LinkElement;

    if (linkElm == null) {
      throw new Exception('The required HTML import for PaperToggleButton was not found in the DOM.');
    }

    final TemplateElement templateElm = linkElm.import.querySelector('#template_paper-toggle-button') as TemplateElement;
    final DocumentFragment frag = templateElm.content.clone(true) as DocumentFragment;

    this._shadowRoot = this.createShadowRoot();
    this._shadowRoot.append(frag);
  }

  @override
  void attached() {
    if (this.attributes.containsKey('disabled') == false) {
      this.shadowRoot.querySelector('#toggle_container').onClick.listen(this._onToggleButtonClicked);
    }
  }

  void _onToggleButtonClicked(final MouseEvent mouseEvent) {
    if (this.attributes.containsKey('checked')) {
      this.attributes.remove('checked');
    } else {
      this.attributes['checked'] = 'checked';
    }
  }
}