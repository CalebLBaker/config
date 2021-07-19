fn main() {
    let url = match std::env::args().skip(1).reduce(|a, b| format!("{} {}", a, b)) {
        Some(q) => format!("https://startpage.com/sp/search?query={}", urlencoding::encode(q.as_ref())),
        None => "https://startpage.com".to_owned()
    };
    std::process::Command::new("vivaldi").arg(url).spawn().unwrap();
}
