[
  "admin",
  "analytics",
  "assets",
  "authentication", 
  "authorization", 
  "blockchain",
  "caching",
  "captcha",
  "cms",
  "cookie",
  "concurrency",
  "configuration",
  "crawlers",
  "cryto",
  "database",
  "debugging",
  "decorators",
  "devops",
  "diff",
  "documentation",
  "email",
  "encryption",
  "error",
  "form",
  "game development",
  "generators",
  "geolocation",
  "graphql",
  "gui",
  "html parsing",
  "image processing",
  "internationalization",
  "javascript", 
  "json",
  "logging",
  "machine learning",
  "measurements",
  "messaging",
  "natural language",
  "networking",
  "optimization",
  "orm",
  "pagination",
  "payments",
  "pdf",
  "performance",
  "postgres",
  "qr",
  "queues",
  "realtime",
  "rss", 
  "scheduling",
  "search", 
  "security",
  "seo",
  "sitemap",
  "spam",
  "storage",
  "styling",
  "testing",
  "upload",
  "video",
  "visualization",
  "websocket",
  "xml parsing"
].each do |name|
  tag = Tag.create(name: name)
  puts tag.inspect
end