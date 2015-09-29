part of PaperElements.lib.paperElements;

class PaperToast extends HtmlElement {
  ShadowRoot _shadowRoot;
  String _message;
  SpanElement _messageElm;
  /// The duration in milliseconds to display the paper toast.
  Duration duration;

  PaperToast.created() : super.created() {
    final LinkElement linkElm = querySelector(r'link[rel="import"][href$="/paper_elements/paper_toast.html"]') as LinkElement;

    if (linkElm == null) {
      throw new Exception('The required HTML import for PaperToast was not found in the DOM.');
    }

    final TemplateElement templateElm = linkElm.import.querySelector('#template_paper-toast') as TemplateElement;
    final DocumentFragment frag = templateElm.content.clone(true) as DocumentFragment;

    this._shadowRoot = this.createShadowRoot();
    this._shadowRoot.append(frag);

    this._messageElm = this._shadowRoot.querySelector('#message') as SpanElement;

    // Check if the element is setting the instance variables using Html attributes
    if (this.attributes.containsKey('message')) {
      this.message = this.attributes['message'];
    }
  }

  // Setters
  void set message(final String messageParam) {
    this._message = messageParam;
    this._messageElm.text = messageParam;
  }

  // Util
  @override
  void attached() {
    super.attached();
  }

  Future<Null> show() {
    final Completer<Null> completer = new Completer<Null>();

    new Timer(const Duration(milliseconds: 1), () {
      this.classes.add('paper_toast_slide_in');

      new Timer(const Duration(milliseconds: 250), () {
        completer.complete();

        // If the duration is set to a value, auto-dismiss in that length of time
        if (this.duration != null) {
          new Timer(this.duration, () {
            this.dismiss();
          });
        }
      });
    });

    return completer.future;
  }

  Future<Null> dismiss() {
    final Completer<Null> completer = new Completer<Null>();

    this.classes.remove('paper_toast_slide_in');

    new Timer(const Duration(milliseconds: 250), () {
      this.remove();
      completer.complete();
    });

    return completer.future;
  }
}