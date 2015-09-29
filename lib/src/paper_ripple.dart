part of PaperElements.lib.paperElements;

class PaperRipple extends HtmlElement {
  ShadowRoot shadowRoot;
  DivElement rippleElm;
  bool recenteringTouch = false;
  StreamSubscription<TransitionEvent> firstTransitionEnd;
  StreamSubscription<TransitionEvent> secondTransitionEnd;

  PaperRipple.created() : super.created() {
    final DocumentFragment frag = ((querySelector(r'link[rel="import"][href$="/paper_elements/paper_ripple.html"]') as LinkElement).import
        .querySelector('#template_paper-ripple') as TemplateElement).content.clone(true);

    this.shadowRoot = this.createShadowRoot();

    this.rippleElm = frag.querySelector('#ripple') as DivElement;
    this.shadowRoot.append(frag);
  }

  void attached() {
    this.recenteringTouch = this.classes.contains('recenteringTouch');
  }

  void play(final MouseEvent event) {
    if (this.firstTransitionEnd != null || this.secondTransitionEnd != null) {
      return;
    }

    final Rectangle clientRect = (event.currentTarget as HtmlElement).getBoundingClientRect();
    double x;
    double y;
    double goalVal;

    if (this.recenteringTouch == false) {
      x = event.client.x - clientRect.left;
      y = event.client.y - clientRect.top;

      if (clientRect.width > clientRect.height) {
        goalVal = x;
      } else {
        goalVal = y;
      }

      if (goalVal < (clientRect.width / 2)) {
        goalVal = clientRect.width - x;
      }

      this.rippleElm.style.left = x.toString() + 'px';
      this.rippleElm.style.top = y.toString() + 'px';
    } else {
      x = clientRect.width / 2;
      y = clientRect.height / 2;

      if (clientRect.width > clientRect.height) {
        goalVal = clientRect.width / 2;
      } else {
        goalVal = clientRect.height / 2;
      }

      this.rippleElm.style.left = x.round().toString() + 'px';
      this.rippleElm.style.top = y.round().toString() + 'px';
    }

    this.firstTransitionEnd = this.onTransitionEnd.listen(this._firstTransitionEndEvent);

    this.rippleElm.classes.add('visible');
    this.rippleElm.classes.add('animate');

    this.rippleElm.style.transform = 'scale(${(goalVal * 2).round().toString()})';
  }

  void _firstTransitionEndEvent(final TransitionEvent event) {
    this.firstTransitionEnd.cancel();
    this.firstTransitionEnd = null;

    this.secondTransitionEnd = this.onTransitionEnd.listen(this._secondTransitionEndEvent);

    this.rippleElm.style.opacity = '0';
  }

  void _secondTransitionEndEvent(final TransitionEvent event) {
    this.secondTransitionEnd.cancel();
    this.secondTransitionEnd = null;

    this.rippleElm.classes.remove('visible');
    this.rippleElm.classes.remove('animate');
    this.rippleElm.style.transform = 'scale(1)';
    this.rippleElm.style.opacity = '1';
  }
}