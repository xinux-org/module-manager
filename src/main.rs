use log::{error, info};
use relm4::{
    gtk::{gio, glib, prelude::ApplicationExt},
    RelmApp, *,
};
use xinux_module_manager::{
    config::{self, RESOURCES_FILE},
    ui::{
        load::load,
        window::{AppInit, AppModel},
    },
};

fn main() {
    gtk::init().unwrap();
    pretty_env_logger::init();

    glib::set_application_name("Module Manager");
    gtk::Window::set_default_icon_name(config::APP_ID);

    if let Ok(res) = gio::Resource::load(RESOURCES_FILE) {
        info!("Resource loaded: {}", RESOURCES_FILE);
        gio::resources_register(&res);
    } else {
        error!("Failed to load resources");
    }

    let app = adw::Application::new(Some(config::APP_ID), gio::ApplicationFlags::empty());
    app.set_resource_base_path(Some("/org/xinux/XinuxModuleManager"));
    let app = RelmApp::new("org.xinux.XinuxModuleManager");

    match load() {
        Ok(load) => app.run::<AppModel>(AppInit { load }),
        Err(e) => {
            error!("Failed to load: {}", e);
            std::process::exit(1);
        }
    }
}
