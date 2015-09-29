part of PaperElements.lib.paperElements;

class PaperCard extends HtmlElement {
  DivElement _content;

  PaperCard.created() : super.created() {
    final LinkElement linkElm = querySelector(r'link[rel="import"][href$="/paper_elements/paper_card.html"]') as LinkElement;

    if (linkElm == null) {
      throw new Exception('The required HTML import for PaperCard was not found in the DOM.');
    }

    final TemplateElement templateElm = linkElm.import.querySelector('#template_paper-card') as TemplateElement;
    final DocumentFragment frag = templateElm.content.clone(true) as DocumentFragment;

    //this.nodes.add(frag);
    //this._content = this.querySelector('#content');
  }

  // Util
  /*
  @override
  void attached() {
    // This weird process must be done this way to avoid conflict with LazyNodeInitialization
    if (this.nodes.length > 0) {
      final DocumentFragment nodeFrag = new DocumentFragment();
      final List<Node> baseNodes = this.nodes;
      final List<Node> newNodes = <Node>[];

      baseNodes.forEach((final Node node) {
        newNodes.add(node.clone(true));
      });

      newNodes.forEach((final Node node) {
        nodeFrag.nodes.add(node);
      });

      this._content.nodes.add(nodeFrag);
    }
  }
  */
}