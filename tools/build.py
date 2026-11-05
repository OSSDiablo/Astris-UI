# src/OblivionUI.luau -> Source.luau (logo baked, minified) and dev.luau (Source + Example, for testing)
import base64, hashlib, shutil, subprocess, sys, tempfile
from pathlib import Path
root = Path(__file__).resolve().parent.parent
logo = (root / "assets" / "logo.png").read_bytes()
src = (root / "src" / "OblivionUI.luau").read_text()
shadow = (root / "assets" / "shadow.png").read_bytes()
src = src.replace("@@SHADOW@@", base64.b64encode(shadow).decode()).replace("@@SHADOWVER@@", hashlib.sha1(shadow).hexdigest()[:8])
src = src.replace("@@LOGO@@", base64.b64encode(logo).decode()).replace("@@LOGOVER@@", hashlib.sha1(logo).hexdigest()[:8])
darklua = next(p for p in (root.home() / ".rokit/tool-storage/seaofvoices/darklua").rglob("darklua") if p.is_file())
with tempfile.TemporaryDirectory() as t:
    a, b = Path(t) / "in.luau", Path(t) / "out.luau"
    a.write_text(src)
    r = subprocess.run([str(darklua), "minify", str(a), str(b)], capture_output=True, text=True)
    if r.returncode:
        sys.exit(r.stderr)
    out = b.read_text()
(root / "Source.luau").write_text(out)
ex = (root / "Example.luau").read_text().splitlines(True)
(root / "dev.luau").write_text("local Oblivion = (function()\n" + out + "\nend)()\n" + "".join(ex[1:]))
print("Source.luau", len(out), "bytes")
