IMPORTANTE: Los archivos MP3 locales tienen problemas de compatibilidad con Flutter Web.

SOLUCIÓN ACTUAL:
- El reproductor usa URLs de audio en línea que funcionan correctamente
- Los archivos MP3 locales necesitan ser convertidos a un formato compatible con Flutter Web

Archivos originales (no funcionales actualmente):
- conciliar_sueno.mp3
- audio_concentracion.mp3
- audio_relajamiento.mp3

Para usar archivos locales:
1. Convierte los MP3 a formato OGG o WAV
2. Actualiza el código para usar AssetSource() en lugar de UrlSource()
3. Asegúrate de que el formato sea compatible con Flutter Web

NOTA: El error "MEDIA_ELEMENT_ERROR: Format error (Code: 4)" indica incompatibilidad de formato.