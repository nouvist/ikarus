const INITIAL_PAGE_HTML: &'static str = include_str!("templates/index.html");
pub fn initial_page_html() -> &'static str {
    INITIAL_PAGE_HTML
}

const PREAMBLE_MD: &'static str = include_str!("templates/preamble.md");
pub fn preamble_md() -> &'static str {
    PREAMBLE_MD
}