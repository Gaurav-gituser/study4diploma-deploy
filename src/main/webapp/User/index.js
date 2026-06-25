// ── Background particle canvas ──────────────────────────────
const canvas = document.getElementById("bgCanvas");
const ctx    = canvas.getContext("2d");

function resizeCanvas() {
  canvas.width  = window.innerWidth;
  canvas.height = window.innerHeight;
}
resizeCanvas();
window.addEventListener("resize", resizeCanvas);

const particles = [];
const PARTICLE_COUNT = 55;

for (let i = 0; i < PARTICLE_COUNT; i++) {
  particles.push({
    x: Math.random() * canvas.width,
    y: Math.random() * canvas.height,
    r: Math.random() * 1.4 + 0.4,       // smaller, cleaner dots
    speed: Math.random() * 0.35 + 0.1,
    opacity: Math.random() * 0.4 + 0.15,
    color: Math.random() > 0.5
      ? `rgba(0,198,255,`               // cyan brand colour
      : `rgba(100,160,255,`             // soft blue
  });
}

function drawParticles() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  particles.forEach(p => {
    ctx.beginPath();
    ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
    ctx.fillStyle = p.color + p.opacity + ")";
    ctx.fill();
  });
}

function updateParticles() {
  particles.forEach(p => {
    p.y += p.speed;
    if (p.y - p.r > canvas.height) {
      p.y = -p.r;
      p.x = Math.random() * canvas.width;
    }
  });
}

(function animate() {
  drawParticles();
  updateParticles();
  requestAnimationFrame(animate);
})();


// ── Typing effect ───────────────────────────────────────────
const texts   = ["notes...", "previous year papers...", "exam resources..."];
let   i = 0, j = 0;
let   isDeleting = false;
const el = document.getElementById("typing");

function type() {
  if (!el) return;
  const current = texts[i];
  if (!isDeleting) {
    el.textContent = current.substring(0, j + 1);
    j++;
    if (j === current.length) {
      isDeleting = true;
      setTimeout(type, 1600);
      return;
    }
  } else {
    el.textContent = current.substring(0, j - 1);
    j--;
    if (j === 0) {
      isDeleting = false;
      i = (i + 1) % texts.length;
    }
  }
  setTimeout(type, isDeleting ? 65 : 110);
}
type();
