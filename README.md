# 🌡️ Gamemax Sigma 520 Digital Linux Driver
Fork de [martiniano/cpu-cooler] [https://github.com/martiniano/cpu-cooler]

Um serviço leve em Python para controlar o display de 7 segmentos em coolers de CPU (especificamente os que se identificam como **MSR-101U / HID 5131:2007** como o Gamemax Sigma 520) no Fedora e em outras distribuições Linux.

## ✨ Funcionalidades
- **Monitoramento em Tempo Real:** Sincroniza a temperatura do "package" da CPU com o display do hardware a cada 2 segundos.
- **Recuperação Robusta:** Detecta e reconecta automaticamente se o cabo USB for desconectado ou se o sistema retornar da suspensão (sleep).
- **Eficiência de Recursos:** Utiliza ciclos de CPU mínimos (<0,1%) e possui um baixo consumo de memória.
- **Instalador de Configuração Zero:** Configuração automatizada para usuários de Fedora.


## 💡 Como Funciona
O script preenche a lacuna entre os sensores térmicos do kernel do Linux e o controlador HID (Human Interface Device) proprietário do cooler.

* **Aquisição de Dados:** Utiliza a biblioteca `psutil` para ler os drivers `k10temp` (AMD) ou `coretemp` (Intel).
* **Comunicação HID:** O cooler se identifica como um "MagTek Card Reader". O script envia relatórios de interrupção brutos de 8 bytes, onde a temperatura é injetada no payload hexadecimal.
* **Integração com Systemd:** Roda como um daemon em segundo plano, garantindo que o display ligue assim que você chegar na tela de login.

---

## 🚀 Instalar
### 1. Instale as Dependências
Abra seu terminal e instale as ferramentas necessárias:

**Fedora:**
```
sudo dnf install -y python3-hidapi python3-psutil
```

**Ubuntu / Debian / Mint:**
```
sudo apt update
sudo apt install python3-hidapi python3-psutil git
```

### 2. Clona o repositório
```
git clone https://github.com/skye6034/cpu-cooler-gamemax-sigma-520-digital.git
cd cpu-cooler-gamemax-sigma-520-digital
```

### 3. Execute o instalador automático
```
chmod +x install.sh
sudo ./install.sh
```
Pronto!

---

# 🌡️ Gamemax Sigma 520 Digital Linux Driver
Forked from [martiniano/cpu-cooler](https://github.com/martiniano/cpu-cooler)

A lightweight Python service to control the 7-segment display on CPU coolers (specifically those identifying as **MSR-101U / HID 5131:2007**, such as the Gamemax Sigma 520) on Fedora and other Linux distributions.


## ✨ Features
- **Real-Time Monitoring:** Syncs the CPU "package" temperature with the hardware display every 2 seconds.
- **Robust Recovery:** Automatically detects and reconnects if the USB cable is disconnected or if the system returns from sleep (suspend).
- **Resource Efficiency:** Uses minimal CPU cycles (<0.1%) and has a low memory footprint.
- **Zero-Config Installer:** Automated setup for Fedora users.


## 💡 How It Works
The script bridges the gap between the Linux kernel's thermal sensors and the cooler's proprietary HID (Human Interface Device) controller.

* **Data Acquisition:** Uses the `psutil` library to read from `k10temp` (AMD) or `coretemp` (Intel) drivers.
* **HID Communication:** The cooler identifies itself as a "MagTek Card Reader." The script sends raw 8-byte interrupt reports, where the temperature is injected into the hexadecimal payload.
* **Systemd Integration:** Runs as a background daemon, ensuring the display turns on as soon as you reach the login screen.

---

## 🚀 Install
### 1. Install Dependencies
Open your terminal and install the required tools:

**Fedora:**
```
sudo dnf install -y python3-hidapi python3-psutil
```
**Ubuntu / Debian / Mint:**
```
sudo apt update
sudo apt install python3-hidapi python3-psutil git
```

### 2. Clone the Repository

```
git clone https://github.com/skye6034/cpu-cooler-gamemax-sigma-520-digital.git
cd cpu-cooler-gamemax-sigma-520-digital
```

### 3. Run the Automated Installer
```
chmod +x install.sh
sudo ./install.sh
```

Done!
