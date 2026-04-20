#include <stdio.h>
#include <syslog.h>
#include <errno.h>
#include <string.h>

int main(int argc, char *argv[]) {
    // 1. Argument-Check (wir brauchen genau 2 + den Programmnamen)
    if (argc != 3) {
        openlog("writer", 0, LOG_USER);
        syslog(LOG_ERR, "Fehler: Zwei Argumente benötigt: <file> <string>");
        closelog();
        return 1;
    }

    const char *file_path = argv[1];
    const char *text_to_write = argv[2];

    // 2. Logging starten
    openlog("writer", 0, LOG_USER);

    // 3. Datei öffnen (Schreibmodus 'w' überschreibt alles)
    FILE *fp = fopen(file_path, "w");
    if (fp == NULL) {
        syslog(LOG_ERR, "Datei konnte nicht geöffnet werden: %s (Errno: %s)", file_path, strerror(errno));
        closelog();
        return 1;
    }

    // 4. Schreiben & Loggen
    syslog(LOG_DEBUG, "Writing %s to %s", text_to_write, file_path);
    if (fputs(text_to_write, fp) == EOF) {
        syslog(LOG_ERR, "Schreibfehler!");
        fclose(fp);
        closelog();
        return 1;
    }

    // 5. Aufräumen
    fclose(fp);
    closelog();
    return 0;
}
