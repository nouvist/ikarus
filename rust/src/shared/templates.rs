const INITIAL_PAGE_HTML: &'static str = include_str!("templates/index.html");
pub fn initial_page_html() -> &'static str {
    INITIAL_PAGE_HTML
}

const PROMPT01: &'static str = include_str!("templates/prompt01_start.md");
pub fn prompt01() -> &'static str {
    PROMPT01
}
