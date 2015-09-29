part of PaperElements.lib.paperElements;

class PaperDialog extends HtmlElement {
  ShadowRoot _shadowRoot;
  String _title;
  String _message;
  /// Object for button titles and actions
  _PaperDialogButtons _buttons = new _PaperDialogButtons();
  List<dynamic> items;
  HeadingElement _titleElm;
  DivElement _messageElm;
  DivElement _actionElm;

  PaperDialog.created() : super.created() {
    final LinkElement linkElm = querySelector(r'link[rel="import"][href$="/paper_elements/paper_dialog.html"]') as LinkElement;

    if (linkElm == null) {
      throw new Exception('The required HTML import for PaperDialog was not found in the DOM.');
    }

    final TemplateElement templateElm = linkElm.import.querySelector('#template_paper-dialog') as TemplateElement;
    final DocumentFragment frag = templateElm.content.clone(true) as DocumentFragment;

    this._shadowRoot = this.createShadowRoot();
    this._shadowRoot.append(frag);
    this._titleElm = this._shadowRoot.querySelector('#title') as HeadingElement;
    this._messageElm = this._shadowRoot.querySelector('#content') as DivElement;
    this._actionElm = this._shadowRoot.querySelector('#actions') as DivElement;

    // Check if the element is setting the instance variables using Html attributes
    if (this.attributes.containsKey('title')) {
      this.title = this.attributes['title'];
    }

    if (this.attributes.containsKey('message')) {
      this.message = this.attributes['message'];
    }
  }

  // Setters
  void set title(final String titleParam) {
    this._title = titleParam;
    this._titleElm.text = titleParam;
  }

  void set message(final String messageParam) {
    this._message = messageParam;
    this._messageElm.text = messageParam;
  }

  // Util
  @override
  void attached() {
    super.attached();

    if (this._buttons.negativeButtonText.isNotEmpty) {
      this._actionElm.append(this._buttons.generateNegativeButton());
    }

    if (this._buttons.positiveButtonText.isNotEmpty) {
      this._actionElm.append(this._buttons.generatePositiveButton());
    }

    this.classes.add('paper-shadow-z-2');
    this.style.top = 'calc(40% - ${(this.clientHeight / 2)}px)';
  }

  void setPositiveButton(final String title, [final SingleOptionalParamFunction onClickAction]) {
    this._buttons.positiveButtonText = title;

    if (onClickAction != null) {
      this._buttons.positiveButtonAction = onClickAction;
    }
  }

  void setNegativeButton(final String title, [final NoParamFunction onClickAction]) {
    this._buttons.negativeButtonText = title;

    if (onClickAction != null) {
      this._buttons.negativeButtonAction = onClickAction;
    }
  }

  void setNeutralButton(final String title, [final NoParamFunction onClickAction]) {
    this._buttons.neutralButtonText = title;

    if (onClickAction != null) {
      this._buttons.neutralButtonAction = onClickAction;
    }
  }

  /**
   * Closes and removes from the DOM.
   */
  Future<Null> close() {
    final Completer<Null> completer = new Completer<Null>();

    new Timer(const Duration(milliseconds: 500), () {
      this.classes.add('paper_dialog_fade_out');

      new Timer(const Duration(milliseconds: 250), () {
        this.remove();
        completer.complete();
      });
    });

    return completer.future;
  }
}

class _PaperDialogButtons {
  String positiveButtonText = '';
  String negativeButtonText = '';
  String neutralButtonText = '';
  NoParamFunction positiveButtonAction;
  NoParamFunction negativeButtonAction;
  NoParamFunction neutralButtonAction;

  _PaperDialogButtons();

  PaperButton generatePositiveButton() {
    final PaperButton button = new Element.tag('paper-button');
    button.label = this.positiveButtonText;
    button.id = "positive_button";
    button.shadowRoot.querySelector('paper-ripple').classes.add('recenteringTouch');

    if (this.positiveButtonAction != null) {
      button.onClick.listen((final MouseEvent mouseEvent) {
        this.positiveButtonAction();
      });
    }

    return button;
  }

  PaperButton generateNegativeButton() {
    final PaperButton button = new Element.tag('paper-button');
    button.label = this.negativeButtonText;
    button.id = 'negative_button';
    button.shadowRoot.querySelector('paper-ripple').classes.add('recenteringTouch');

    if (this.negativeButtonAction != null) {
      button.onClick.listen((final MouseEvent mouseEvent) {
        this.negativeButtonAction();
      });
    }

    return button;
  }
}