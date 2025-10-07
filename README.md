# 🧩 FixSol Pro Edition

**A modern Bash CLI to check and fix your Solana + Anchor development environment**  
> Your personal “anchor doctor” 🧙‍♂️ — verify, fix and optimize your setup in seconds ⚡  

---

## 🚀 Features

✅ **Check your entire Solana dev setup automatically:**  
- Solana CLI  
- Anchor CLI  
- Rust toolchain  
- (optional) Node, npm, Cargo, and `solana-test-validator`

🧠 **Automatic repair mode**  
- Fix wrong Solana symlinks  
- Switch or install correct Anchor version (`avm`)  
- Update Rust if needed

🎨 **Clean colored output + easy-to-read summary**

🩺 **Modes**
| Mode | Command | Description |
|------|----------|-------------|
| 🧰 Default | `fixsol` | Check + auto-fix environment |
| 🩺 Doctor | `fixsol --doctor` | Check only (no modification) |
| 🔍 Deep Scan | `fixsol --deep` | Extended check (Node, npm, Cargo, validator) |

---

## ⚙️ Installation

```bash
git clone https://github.com/jerem0010/fixsol.git
cd fixsol
chmod +x fixsol_pro.sh
echo 'alias fixsol="~/fixsol/fixsol_pro.sh"' >> ~/.zshrc
source ~/.zshrc
```
---

## 🧱 Example Output

```bash
🧩 FixSol Pro Edition
-------------------------------------------
🔍 Mode deep scan activé

⚙ Vérification de ton environnement...

  ✔ Solana       : 1.18.21
  ✔ Anchor       : 0.31.1
  ✔ Rust         : 1.90.0

⚙ Scan supplémentaire...

  ✔ Node.js : v23.11.0
  ✔ npm     : 11.3.0
  ✔ Cargo   : cargo 1.90.0 (840b83a10 2025-07-30)

⚙ Test du validator local...
  ✔ Validator prêt

✅ Environnement propre et prêt à builder ton projet Anchor 🚀
```
---

## 📦 Requirements

- **Solana CLI** ≥ 1.18.21  
- **Anchor CLI** = 0.31.1  
- **Rust** ≥ 1.81.0  
- Optional: `node`, `npm`, `cargo`, `solana-test-validator`

---

## 🧠 Why FixSol?

Because every Solana dev knows the pain of:
- mismatched versions between Solana and Anchor 😭  
- random “idl error” or “unexpected cfg” warnings 😤  
- Rust outdated toolchains 😩  

💡 **FixSol Pro Edition** ensures everything is clean, aligned and ready to ship — automatically.

---

## 🛠 Tech Stack

- **Language:** Bash  
- **Platform:** Linux / WSL2  
- **Target:** Solana / Anchor / Rust ecosystem  
- **Shells supported:** `bash`, `zsh`

