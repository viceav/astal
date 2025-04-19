namespace AstalNiri {
public class Window : Object {
    /** unique id of window*/
    public int64 id { get; private set; }
    /** name of the window, if available */
    public string? title { get; private set; }
    /** app_id of the window, if available  */
    public string? app_id { get; private set; }
    // TODO: move window to new workspace on set */
    /** workspace_id of the window, if available  */
    public Workspace? workspace { get; private set; }
    /** if this is the current Focused Window */
    public bool is_focused { get; internal set; }

    public signal void changed();
    public signal void closed();

    internal Window.from_json(Json.Object object) {
        sync(object);
    }

    internal void sync(Json.Object object) {
        id = object.get_int_member("id");
        title = object.get_member("title").get_string();
        app_id = object.get_member("app_id").get_string();
        var _workspace_id = object.get_member("workspace_id");
        is_focused = object.get_boolean_member("is_focused");

        if (_workspace_id.is_null()) { workspace = null; }
        else {
            workspace = Niri.get_default().get_workspace(_workspace_id.get_int());
        }
    }
}
}
