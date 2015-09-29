library PaperElements.lib.paperElements;

import "dart:html";
import "dart:async";
import "package:core_icon/core_elements.dart" as CoreElements;

part "src/paper_action_bar.dart";
part "src/paper_button.dart";
part "src/paper_card.dart";
part "src/paper_dialog.dart";
part "src/paper_focusable.dart";
part "src/paper_icon_button.dart";
part "src/paper_ripple.dart";
part "src/paper_shadow.dart";
part "src/paper_snackbar.dart";
part "src/paper_toast.dart";
part "src/paper_toggle_button.dart";

typedef NoParamFunction();
typedef SingleOptionalParamFunction([final dynamic data]);

void registerWithDom() {
  document.registerElement('paper-action-bar', PaperActionBar);
  document.registerElement('paper-button', PaperButton);
  document.registerElement('paper-card', PaperCard);
  document.registerElement('paper-dialog', PaperDialog);
  document.registerElement('paper-icon-button', PaperIconButton);
  document.registerElement('paper-ripple', PaperRipple);
  document.registerElement('paper-shadow', PaperShadow);
  document.registerElement('paper-snackbar', PaperSnackbar);
  document.registerElement('paper-toast', PaperToast);
  document.registerElement('paper-toggle-button', PaperToggleButton);
}