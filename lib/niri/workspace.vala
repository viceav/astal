namespace AstalNiri {
public class Workspace : Object {
    /** unique id of workspace */
    public int64 id { get; private set; }
    /** index of the workspace on its monitor */
    public uint8 idx { get; private set; }
    /** optional name of the workspace */
    public string? name { get; private set; }
    // TODO: move workspace to new output on set */
    /** nome of the output the workspace is on */
    public string? output { get; internal set; }
    /** if the workspace is active on its outpput */
    public bool is_active { get; internal set; }
    /** if this is the current Focused Workspace */
    public bool is_focused { get; internal set; }
    /** id of the active window on the workspace */
    public Window? active_window {get; internal set;}
    /* public List<weak Window> windows { owned get {
     return Niri._windows.get_values().copy(); 
    } } */

    // private List<weak Window> _windows = new List<weak Window>();
    // public List<weak Window> windows { owned get { return _windows.copy(); } }

    /** Emitted when a workspace was activated on an output. */
    public signal void activated();
    /** Emitted when the window changes on a workspace. */
    public signal void active_window_changed(Window? window);

    internal Workspace.from_json(Json.Object object) {
        sync(object);
    }

    internal void sync(Json.Object object) {
        id = object.get_int_member("id");
        idx = (uint8) object.get_int_member("idx");
        name = object.get_member("name").get_string();
        output = object.get_member("output").get_string();
        is_active = object.get_boolean_member("is_active");
        is_focused = object.get_boolean_member("is_focused");
        var _active_window_id = object.get_member("active_window_id");

        if (_active_window_id.is_null()) { active_window = null; }
        else { active_window = Niri.get_default().get_window(_active_window_id.get_int()); }
    }
}
}
