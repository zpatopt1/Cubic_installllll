## Fazer primeiro dentro do cubic

### 1. Atualizar o sistema
apt update  
apt install -y wget ca-certificates

### 1. Download 
wget https://raw.githubusercontent.com/zpatopt1/Cubic_installllll/main/installsh.sh -O /root/install.sh
### 2. Dar Permissoes
chmod +x /root/install.sh

### 3. Converter em 2unix para nao dar erro de scripts de mal formataçao
apt install -y dos2unix  
dos2unix /root/install.sh  

### 4. Executar
bash /root/install.sh

### 5. Completo
apt update  
apt install -y wget ca-certificates  
wget https://raw.githubusercontent.com/zpatopt1/Cubic_installllll/main/installsh.sh -O /root/install.sh  
chmod +x /root/install.sh  
apt install -y dos2unix  
dos2unix /root/install.sh  
bash /root/install.sh  




