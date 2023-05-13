# WiMazzer

A login script for Wi-Mazza, my college wifi in Padua.

![Linux ok](https://img.shields.io/badge/supported-Linux-brightgreen)
![Windows nope](https://img.shields.io/badge/nope-Windows-red)

<p align="center">
🇮🇹 italian instructions only
</p>


## Guida all'uso

**1)** Scarica questo repo in una cartella a tua scelta. **Consiglio di usare la tua home**, perché lo script conterrà la tua password per Wi-Mazza.

**2)** Modifica il file `wimazzer.sh` con il tuo **username e password**. Ad esempio, se il tuo username è *dincag* e la password è *mor1eno2*, le righe 18 e 19 del file saranno:
```bash
USERNAME="dincag"
PASSWORD="mor1eno2"
```

**3)** Garantisci il permesso di esecuzione allo script.
```bash
chmod +x wimazzer.sh
```

<br>

*nota)* A questo punto potresti già eseguire lo script per testare il login (`./wimazzer.sh`). Potresti aggiungere un *alias* al tuo bashrc per richiamare velocemente lo script con un comando, oppure impostare l'esecuzione automatica (segui il resto delle istruzioni).

<br>

**4)** Modifica il file `wimazza.service` con il percorso completo al file eseguibile. Puoi trovare il percorso completo alla cartella corrente con il comando `pwd`. Ad esempio, se hai scaricato questo repo nella tua home, la riga 6 del file `wimazza.service` dovrà essere
```bash
ExecStart=/bin/bash /home/baronefr/wimazzer/wimazzer.sh
```

<br>

*nota)* Se vuoi modificare i timing di esecuzione dello script, guarda adesso [questa sezione](#controllo-del-timing).

<br>

**5)** Copia i servizi systemd.
```bash
sudo cp wimazza.* /etc/systemd/system/
```

**6)** Abilita il timer.
```bash
sudo systemctl enable wimazza.timer
```


<br><br>


### controllo del timing

Modificando il file `wimazza.timer` si potrà controllare il timing di esecuzione dello script:
- `OnUnitActiveSec` (default: 1min): il tempo che intercorre tra un controllo del login e il successivo.
- `OnActiveSec` (default: 5s): il tempo di attesa dell'esecuzione a partire dall'avvio dei timer.

Di default, il file è configurato nel seguente modo:
```bash
[Timer]
OnUnitActiveSec=1min
OnActiveSec=5s
```

Ti ricordo che se hai già completato l'installazione, al fine di modificare i timing devi **ricopiare i file modificati in systemd**, quindi riesegui i passaggi 5 e 6.

***

Barone Francesco - [git@baronefr](github.com/baronefr/)
