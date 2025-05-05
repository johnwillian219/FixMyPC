import os
import shutil
import psutil
import subprocess
import time

def print_status(message):
    print(f"[*] {message}")

def clean_temp_files():
    """Limpa arquivos temporários do sistema."""
    temp_folders = [
        os.path.expanduser(r"~\AppData\Local\Temp"),
        r"C:\Windows\Temp"
    ]
    
    for folder in temp_folders:
        try:
            for item in os.listdir(folder):
                item_path = os.path.join(folder, item)
                try:
                    if os.path.isfile(item_path):
                        os.unlink(item_path)
                    elif os.path.isdir(item_path):
                        shutil.rmtree(item_path)
                    print_status(f"Removido: {item_path}")
                except Exception as e:
                    print_status(f"Erro ao remover {item_path}: {e}")
        except Exception as e:
            print_status(f"Erro ao acessar {folder}: {e}")

def stop_unnecessary_processes():
    """Encerra processos desnecessários para liberar memória."""
    unnecessary_processes = ['notepad.exe', 'calc.exe']  # Adicione processos que deseja encerrar
    for proc in psutil.process_iter(['name']):
        try:
            if proc.info['name'].lower() in unnecessary_processes:
                proc.terminate()
                print_status(f"Processo {proc.info['name']} encerrado.")
        except Exception as e:
            print_status(f"Erro ao encerrar {proc.info['name']}: {e}")

def clear_cache():
    """Limpa o cache do sistema."""
    try:
        subprocess.run('ipconfig /flushdns', shell=True, check=True)
        print_status("Cache DNS limpo.")
    except Exception as e:
        print_status(f"Erro ao limpar cache DNS: {e}")

def disable_startup_programs():
    """Desativa programas desnecessários na inicialização (via msconfig)."""
    try:
        # Este comando apenas abre o msconfig; para automação total, use bibliotecas como `winreg`
        print_status("Abrindo 'msconfig' para revisão manual de programas de inicialização.")
        subprocess.run('msconfig', shell=True, check=True)
    except Exception as e:
        print_status(f"Erro ao abrir msconfig: {e}")

def main():
    print_status("Iniciando otimização do sistema...")
    
    # Executa as funções de otimização
    clean_temp_files()
    stop_unnecessary_processes()
    clear_cache()
    disable_startup_programs()
    
    print_status("Otimização concluída! Reinicie o computador para melhores resultados.")

if __name__ == "__main__":
    # Verifica se o script está sendo executado como administrador
    try:
        import ctypes
        is_admin = ctypes.windll.shell32.IsUserAnAdmin()
        if not is_admin:
            print_status("Este script precisa ser executado como administrador!")
            input("Pressione Enter para sair...")
            exit()
        main()
    except Exception as e:
        print_status(f"Erro geral: {e}")
    input("Pressione Enter para sair...")