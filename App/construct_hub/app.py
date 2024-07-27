import os
from flask import Flask, request, jsonify
import convertapi
from werkzeug.utils import secure_filename

app = Flask(__name__)

# Set your ConvertAPI secret
convertapi.api_secret = 'your-key'

# Configure the upload folder
UPLOAD_FOLDER = 'uploads'
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/convert', methods=['POST'])
def convert_dwg_to_pdf():
    try:
        # Check if file is present in the request
        if 'file' not in request.files:
            return jsonify({'error': 'No file part'}), 400

        file = request.files['file']

        # Check if the file is of allowed type
        if file.filename == '':
            return jsonify({'error': 'No selected file'}), 400

        # Check if the file is a DWG file
        if file and file.filename.endswith('.dwg'):
            # Save the file to upload folder
            filename = secure_filename(file.filename)
            file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(file_path)

            # Convert DWG to PDF using the file path
            result = convertapi.convert('pdf', {'File': file_path})

            # Save the converted file
            pdf_file_path = os.path.join(app.config['UPLOAD_FOLDER'], 'output.pdf')
            result.file.save(pdf_file_path)

            return jsonify({'message': 'Conversion successful', 'pdf_file': pdf_file_path}), 200
        else:
            return jsonify({'error': 'Invalid file type, only DWG files are allowed'}), 400
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
