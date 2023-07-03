import { Controller } from 'stimulus';

export default class extends Controller {
  openVideoCall() {
    const eventName = 'Room 1';

    const newWindow = window.open('', eventName, 'width=800,height=600');

    const htmlContent = `
      <html>
        <head>
          <title>${eventName}</title>
          <script src="https://unpkg.com/@daily-co/daily-js"></script>
        </head>
        <body>
          <div id="callFrameContainer"></div>
          <script>
            const callFrame = window.DailyIframe.createFrame({
              showLeaveButton: true,
              iframeStyle: {
                position: 'fixed',
                top: '0',
                left: '0',
                width: '100%',
                height: '100%',
              },
            });

            callFrame.join({ url: 'https://peppermingle.daily.co/Room-1' });
            document.getElementById('callFrameContainer').appendChild(callFrame.element);
          </script>
        </body>
      </html>
    `;

    newWindow.document.open();
    newWindow.document.write(htmlContent);
    newWindow.document.close();
  }
}
