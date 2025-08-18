#!/usr/bin/env gjs

imports.gi.versions.Gtk = "4.0";
imports.gi.versions.Gtk4LayerShell = "1.0";
const Gtk4LayerShell = imports.gi.Gtk4LayerShell;
const { Gtk, GLib } = imports.gi;

const BEDTIME_START = 22; // 10 PM
const BEDTIME_END = 8;    // 8 AM

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

    // Function to update the label
    function updateTime() {
        const now = new Date();
        let hours = now.getHours();
        let minutes = now.getMinutes();
        let seconds = now.getSeconds();

        // Don't display anything after 7 AM (bedtime is over)
        if (hours >= BEDTIME_END && hours < BEDTIME_START) {
            label.set_text("");
            return true;
        }

        // fractional hour
        let decimalHour = hours + minutes / 60 + seconds / 3600;

        let timeFromBed = decimalHour - BEDTIME_START;
        if (timeFromBed < 0) timeFromBed += 24; // handle crossing midnight

        label.set_text(timeFromBed.toFixed(2)); // show 2 decimals
        return true; // keep timeout running
    }
    // Update every second (or every minute if you want)
    GLib.timeout_add_seconds(GLib.PRIORITY_DEFAULT, 1, updateTime);

    win.present();
});

app.run([]);
