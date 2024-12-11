module fzl {
    requires javafx.controls;
    requires javafx.fxml;

    opens fzl to javafx.fxml;
    exports fzl;
}
