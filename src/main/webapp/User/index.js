
const canvas = document.getElementById("bgCanvas");
const ctx = canvas.getContext("2d");
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

let dots = [];
const colors = [
  "rgba(0, 212, 255, 1)",
  "rgba(0, 100, 200, 1)",
  "rgba(200, 100, 255, 1)",
  "rgba(120, 0, 180, 1)"
];

for (let i = 0; i < 50; i++) {
  dots.push({
    x: Math.random() * canvas.width,
    y: Math.random() * canvas.height,
    radius: Math.random() * 20 + 10,
    speed: Math.random() * 0.5 + 0.2,
    glow: Math.random() * 40 + 80,
    color: colors[Math.floor(Math.random() * colors.length)]
  });
}

function drawDots() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  dots.forEach(dot => {
    ctx.beginPath();
    ctx.shadowBlur = dot.glow;
    ctx.shadowColor = dot.color;
    ctx.fillStyle = dot.color;
    ctx.arc(dot.x, dot.y, dot.radius, 0, Math.PI * 2, false);
    ctx.fill();
    ctx.shadowBlur = 0;
  });
}

function updateDots() {
  dots.forEach(dot => {
    dot.y += dot.speed;
    if (dot.y - dot.radius > canvas.height) {
      dot.y = -dot.radius;
      dot.x = Math.random() * canvas.width;
    }
  });
}

function animate() {
  drawDots();
  updateDots();
  requestAnimationFrame(animate);
}
animate();

window.addEventListener("resize", () => {
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
});

// Typing Effect
const texts = ["notes...", "previous years paper..."];
let i = 0, j = 0;
let currentText = "";
let isDeleting = false;
const typingElement = document.getElementById("typing");

function type() {
  currentText = texts[i];
  if (!isDeleting) {
    typingElement.textContent = currentText.substring(0, j + 1);
    j++;
    if (j === currentText.length) {
      isDeleting = true;
      setTimeout(type, 1500);
      return;
    }
  } else {
    typingElement.textContent = currentText.substring(0, j - 1);
    j--;
    if (j === 0) {
      isDeleting = false;
      i = (i + 1) % texts.length;
    }
  }
  setTimeout(type, isDeleting ? 80 : 120);
}
type();


