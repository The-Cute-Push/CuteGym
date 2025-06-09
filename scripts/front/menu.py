import customtkinter as ctk
from tkinter import messagebox

# Inicializar a aparência
ctk.set_appearance_mode("System")  # "Dark", "Light", "System"
ctk.set_default_color_theme("blue")  # Azul é o padrão

class LoginApp(ctk.CTk):
    def __init__(self):
        super().__init__()

        self.title("Login")
        self.geometry("300x250")
        self.resizable(False, False)

        # Título
        self.label_title = ctk.CTkLabel(self, text="Bem-vindo", font=ctk.CTkFont(size=20, weight="bold"))
        self.label_title.pack(pady=15)

        # Entrada de usuário
        self.entry_user = ctk.CTkEntry(self, placeholder_text="Usuário")
        self.entry_user.pack(pady=10)

        # Entrada de senha
        self.entry_password = ctk.CTkEntry(self, placeholder_text="Senha", show="*")
        self.entry_password.pack(pady=10)

        # Botão de login
        self.button_login = ctk.CTkButton(self, text="Entrar", command=self.login)
        self.button_login.pack(pady=15)

    def login(self):
        username = self.entry_user.get()
        password = self.entry_password.get()

        # Aqui você pode validar com dados reais ou com um dicionário de exemplo
        if username == "admin" and password == "123":
            messagebox.showinfo("Login", "Login bem-sucedido!")
        else:
            messagebox.showerror("Erro", "Usuário ou senha incorretos.")

if __name__ == "__main__":
    app = LoginApp()
    app.mainloop()
