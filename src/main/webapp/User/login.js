const canvas = document.getElementById("bgCanvas"), ctx = canvas.getContext("2d"); canvas.width = window.innerWidth; canvas.height = window.innerHeight;
    let dots = [], colors = ["rgba(0,212,255,1)", "rgba(0,100,200,1)", "rgba(200,100,255,1)", "rgba(120,0,180,1)"];
    for (let i = 0; i < 50; i++) { dots.push({ x: Math.random() * canvas.width, y: Math.random() * canvas.height, radius: Math.random() * 20 + 10, speed: Math.random() * 0.5 + 0.2, glow: Math.random() * 40 + 80, color: colors[Math.floor(Math.random() * colors.length)] }); }
    function draw() { ctx.clearRect(0, 0, canvas.width, canvas.height); dots.forEach(d => { ctx.beginPath(); ctx.shadowBlur = d.glow; ctx.shadowColor = d.color; ctx.fillStyle = d.color; ctx.arc(d.x, d.y, d.radius, 0, Math.PI * 2, false); ctx.fill(); ctx.shadowBlur = 0; }); }
    function update() { dots.forEach(d => { d.y += d.speed; if (d.y - d.radius > canvas.height) { d.y = -d.radius; d.x = Math.random() * canvas.width; } }); }
    function animate() { draw(); update(); requestAnimationFrame(animate); } animate();
    window.addEventListener("resize", () => { canvas.width = window.innerWidth; canvas.height = window.innerHeight; });