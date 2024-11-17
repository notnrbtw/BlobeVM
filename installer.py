from textual.app import App, ComposeResult
from textual.screen import Screen
from textual.containers import Horizontal, Vertical
from textual.widgets import Footer, Header, SelectionList, Label, Button, Markdown, Select, Static, Switch
import json

### JSON Exporter ###

def savejson(data):
    with open('options.json', 'w') as f:
        json.dump(data, f, indent=4)

#####################

Head = """
# BlobeVM Installer

> BlobeVM (Powered by DesktopOnCodespaces)

BlobeVM is a Virtual Machine that...
* Runs entirely in a web browser
* Is unblocked
* Has Windows app support
* Has audio support
* Can run games with almost no lag
* Can bypass school networks
* Is very fast
* Is the latest
"""

InstallHead = """
# BlobeVM Installer
"""     

LINES = [
    "KDE Plasma 6 (Heavy)", 
    "XFCE 4.18 (Lightweight)", 
    "I3 (Very Lightweight)", 
    "GNOME 46 (Very Heavy)", 
    "Cinnamon", 
    "LXQT"
]

class InstallScreen(Screen):
    CSS_PATH = "installer.tcss"

    def compose(self) -> ComposeResult:
        yield Header()
        yield Markdown(InstallHead)
        
        yield Vertical(
            Label("Default Apps (you should keep them) and includes chat, games, browser, zip extractors"),
            SelectionList[int](
                ("Wine", 0, True),
                ("Chrome", 1, True),
                ("Xarchiver", 2, True),
                ("Discord", 3, True),
                ("Steam", 4, True),
                ("Minecraft", 5, True),
                id="defaultapps"
            ),
        )
        
        yield Vertical(
            Label("Programming & Coding"),
            SelectionList[int](
                ("OpenJDK 8 (jre)", 0),
                ("OpenJDK 17 (jre)", 1),
                ("VSCodium", 2),
                id="programming"
            ),
        )
        
        yield Vertical(
            Label("Apps & Virtual Machines & Media Players & Office & Games & Installers"),
            SelectionList[int](
                ("VLC", 0),
                ("LibreOffice", 1),
                ("Synaptic", 2),
                ("AQemu (VMs)", 3),
                ("TLauncher", 4),
                id="apps"
            ),
        )
        
        yield Vertical(
            Horizontal(
                Label("\nDesktop Environment:"),
                Select(id="de", value="KDE Plasma 6 (Heavy)", options=[(line, line) for line in LINES]),
            ),
        )
        
        yield Horizontal(
            Button.error("Back", id="back"),
            Button.warning("Install NOW", id="in"),
        )

    def on_button_pressed(self, event: Button.Pressed) -> None:
        if event.button.id == "back":
            app.pop_screen()
        elif event.button.id == "in":
            data = {
                "defaultapps": self.query_one("#defaultapps").selected,
                "programming": self.query_one("#programming").selected,
                "apps": self.query_one("#apps").selected,
                "enablekvm": True,
                "DE": self.query_one("#de").value
            }
            savejson(data)
            app.exit()

class InstallApp(App):
    CSS_PATH = "installer.tcss"

    def compose(self) -> ComposeResult:
        yield Header()
        yield Markdown(Head)
        yield Vertical(
            Button.success("Install", id="install"),
        )

    def on_button_pressed(self, event: Button.Pressed) -> None:
        if event.button.id == "install":
            self.push_screen(InstallScreen())

if __name__ == "__main__":
    app = InstallApp()
    app.run()
