// WebRTCManager.java (legacy-код)
public class WebRTCManager {
    private static WebRTCManager instance;
    private PeerConnection peerConnection;

    // Проблема 1: Синглтон с утечкой контекста
    public static WebRTCManager getInstance(Context context) {
        if (instance == null) {
            instance = new WebRTCManager(context);
        }
        return instance;
    }

    private WebRTCManager(Context context) {
        // Проблема 2: Инициализация WebRTC без проверки
        PeerConnectionFactory.initialize(PeerConnectionFactory.InitializationOptions
            .builder(context)
            .createInitializationOptions());
        
        // Проблема 3: Создание PeerConnection с устаревшими параметрами
        peerConnection = factory.createPeerConnection(servers, constraints, observer);
    }

    // Проблема 4: AsyncTask для сетевых операций
    private class SignalingTask extends AsyncTask<String, Void, String> {
        @Override
        protected String doInBackground(String... urls) {
            // Проблема 5: Отсутствие обработки поворота экрана
            return downloadUrl(urls[0]);
        }
        
        @Override
        protected void onPostExecute(String result) {
            // Проблема 6: Обновление UI из фонового потока
            updateUI(result);
        }
    }
}
