use flutter_rust_bridge::frb;
use rfd::FileDialog;

#[frb]
pub struct FileDialogFilter {
    pub name: String,
    pub extensions: Vec<String>,
}

fn prepare(filters: Vec<FileDialogFilter>) -> FileDialog {
    let mut rfd = rfd::FileDialog::new();
    for filter in &filters {
        rfd = rfd.add_filter(filter.name.clone(), &filter.extensions);
    }

    rfd
}

pub fn open(filters: Vec<FileDialogFilter>) -> Option<String> {
    let path = prepare(filters).pick_file();
    match path {
        Some(it) => Some(it.to_string_lossy().to_string()),
        None => None,
    }
}

pub fn save(filters: Vec<FileDialogFilter>) -> Option<String> {
    let path = prepare(filters).save_file();
    match path {
        Some(it) => Some(it.to_string_lossy().to_string()),
        None => None,
    }
}
