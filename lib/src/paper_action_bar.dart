part of PaperElements.lib.paperElements;

class PaperActionBar extends HtmlElement {
  String _title;
  ShadowRoot _shadowRoot;
  //final dynamic upBtn;
  final _PaperActionBarMenu menu = new _PaperActionBarMenu();

  PaperActionBar.created() : super.created() {
    final Document htmlImport = (querySelector(r'link[rel="import"][href$="/paper_elements/paper_action_bar.html"]') as LinkElement).import;
    final DocumentFragment elmFrag = (htmlImport.querySelector('#template_paper-action-bar') as TemplateElement).content.clone(true);

    this._shadowRoot = this.createShadowRoot();
    this.shadowRoot.append(elmFrag);
  }
}

class _PaperActionBarMenu {
  _PaperActionBarMenu();
}