if Rails.env.production?
  SitemapGenerator::Sitemap.default_host = ENV['APP_URL']
  SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
  SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
    ENV['AWS_BUCKET_NAME'],
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['AWS_REGION'])
  SitemapGenerator::Sitemap.create do
    add home_path, priority: 0.7, changefreq: 'weekly'
    Gemm.find_each do |gemm|
      add gem_path(gemm), priority: 0.8, changefreq: 'weekly', lastmod: gemm.updated_at
    end
    User.find_each do |user|
      add user_path(user), priority: 0.9, changefreq: 'weekly', lastmod: user.updated_at
    end
    Tag.find_each do |tag|
      add tag_path(tag), priority: 0.6, changefreq: 'monthly', lastmod: tag.updated_at
    end
  end
end