<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Multi-Tool App</title>
<style>
    body {
        font-family: sans-serif;
        margin: 0;
        background: #f0f0f0;
    }
    .nav {
        display: flex;
        justify-content: space-around;
        background: #222;
        color: white;
    }
    .nav button {
        flex: 1;
        padding: 15px 0;
        background: none;
        border: none;
        color: white;
        font-size: 16px;
    }
    .room {
        display: none;
        padding: 20px;
    }
    .active {
        display: block;
    }
    .calc, .currency, .camera {
        background: white;
        border-radius: 10px;
        padding: 15px;
        box-shadow: 0 0 10px rgba(0,0,0,0.2);
    }
    .calc input, .currency input {
        width: 100%;
        padding: 10px;
        font-size: 24px;
        margin-bottom: 10px;
        box-sizing: border-box;
    }
    .buttons {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 10px;
    }
    .buttons button {
        padding: 20px;
        font-size: 20px;
        border: none;
        border-radius: 8px;
        background: #ddd;
    }
    .buttons button:hover {
        background: #bbb;
    }
    video {
        width: 100%;
        border-radius: 10px;
    }
</style>
</head>
<body>

<div class="nav">
    <button onclick="showRoom('calculator')">Calculator</button>
    <button onclick="showRoom('currency')">Currency</button>
    <button onclick="showRoom('camera')">Camera</button>
</div>

<div id="calculator" class="room active">
    <div class="calc">
        <input type="text" id="calcDisplay" readonly>
        <div class="buttons">
            <button onclick="appendCalc('7')">7</button>
            <button onclick="appendCalc('8')">8</button>
            <button onclick="appendCalc('9')">9</button>
            <button onclick="appendCalc('/')">/</button>

            <button onclick="appendCalc('4')">4</button>
            <button onclick="appendCalc('5')">5</button>
            <button onclick="appendCalc('6')">6</button>
            <button onclick="appendCalc('*')">*</button>

            <button onclick="appendCalc('1')">1</button>
            <button onclick="appendCalc('2')">2</button>
            <button onclick="appendCalc('3')">3</button>
            <button onclick="appendCalc('-')">-</button>

            <button onclick="appendCalc('0')">0</button>
            <button onclick="appendCalc('.')">.</button>
            <button onclick="calculate()">=</button>
            <button onclick="appendCalc('+')">+</button>

            <button onclick="clearCalc()" style="grid-column: span 4;">C</button>
        </div>
    </div>
</div>

<div id="currency" class="room">
    <div class="currency">
        <input type="number" id="amount" placeholder="Amount">
        <select id="fromCurrency">
            <option value="USD">USD</option>
            <option value="EUR">EUR</option>
            <option value="KES">KES</option>
        </select>
        <select id="toCurrency">
            <option value="USD">USD</option>
            <option value="EUR">EUR</option>
            <option value="KES">KES</option>
        </select>
        <button onclick="convertCurrency()">Convert</button>
        <p id="currencyResult"></p>
    </div>
</div>

<div id="camera" class="room">
    <div class="camera">
        <video id="video" autoplay></video>
        <button onclick="takePhoto()">Take Photo</button>
        <canvas id="canvas" style="display:none;"></canvas>
    </div>
</div>

<script>
function showRoom(room) {
    document.querySelectorAll('.room').forEach(r => r.classList.remove('active'));
    document.getElementById(room).classList.add('active');
}

// Calculator functions
let calcInput = '';
function appendCalc(val) {
    calcInput += val;
    document.getElementById('calcDisplay').value = calcInput;
}
function calculate() {
    try {
        calcInput = eval(calcInput).toString();
        document.getElementById('calcDisplay').value = calcInput;
    } catch {
        document.getElementById('calcDisplay').value = 'Error';
        calcInput = '';
    }
}
function clearCalc() {
    calcInput = '';
    document.getElementById('calcDisplay').value = '';
}

// Currency converter
function convertCurrency() {
    let amount = parseFloat(document.getElementById('amount').value);
    let from = document.getElementById('fromCurrency').value;
    let to = document.getElementById('toCurrency').value;
    let rates = {USD:1, EUR:0.9, KES:150}; // Example rates
    let result = amount / rates[from] * rates[to];
    document.getElementById('currencyResult').innerText = result.toFixed(2) + ' ' + to;
}

// Camera
navigator.mediaDevices.getUserMedia({video:true})
.then(stream => document.getElementById('video').srcObject = stream)
.catch(err => console.error(err));
function takePhoto() {
    const video = document.getElementById('video');
    const canvas = document.getElementById('canvas');
    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;
    canvas.getContext('2d').drawImage(video,0,0);
    const dataUrl = canvas.toDataURL('image/png');
    const link = document.createElement('a');
    link.href = dataUrl;
    link.download = 'photo.png';
    link.click();
}
</script>

</body>
</html>#dd3636