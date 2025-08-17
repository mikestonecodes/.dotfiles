#!/usr/bin/env gjs

imports.gi.versions.Gtk = "4.0";
imports.gi.versions.Gtk4LayerShell = "1.0";
const Gtk4LayerShell = imports.gi.Gtk4LayerShell;
const { Gtk, GLib } = imports.gi;

const BEDTIME_START = 22; // 10 PM
const BEDTIME_END = 8;    // 8 AM

let currentHour = new Date().getHours();
let timeFromBed = currentHour - BEDTIME_START; // original value
timeFromBed = timeFromBed + 0.5; // add decimal for testing

const app = new Gtk.Application();

app.connect("activate", () => {
    let win = new Gtk.ApplicationWindow({ application: app });
    Gtk4LayerShell.init_for_window(win);
    Gtk4LayerShell.set_layer(win, Gtk4LayerShell.Layer.OVERLAY);
    Gtk4LayerShell.set_anchor(win, Gtk4LayerShell.Edge.TOP, true);
    Gtk4LayerShell.set_anchor(win, Gtk4LayerShell.Edge.LEFT, true);
    Gtk4LayerShell.set_margin(win, Gtk4LayerShell.Edge.TOP, 0);
    Gtk4LayerShell.set_margin(win, Gtk4LayerShell.Edge.LEFT, 0);

    let label = new Gtk.Label({ css_classes: ["big-number"] });
    label.set_text("" + timeFromBed);
    win.set_child(label);

    // CSS
    const css = new Gtk.CssProvider();
    const cssData = `
        .big-number {
            font-size: 48px;
            font-weight: bold;
            color: red;
        }
        window {
            background-color: transparent;
        }
    `;
    css.load_from_data(cssData, cssData.length);
    Gtk.StyleContext.add_provider_for_display(
        win.get_display(),
        css,
        Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION,
    );

    // Keep running indefinitely
    GLib.timeout_add_seconds(GLib.PRIORITY_DEFAULT, 60, () => true); // dummy timeout to keep app alive

    win.present();
});

app.run([]);
