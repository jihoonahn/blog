const currentPageURL = window.location.href;
let lvl0Value;

if (currentPageURL.includes('/blog')) {
  lvl0Value = 'Blog';
} else if (currentPageURL.includes('/about')) {
  lvl0Value = 'About';
} else if (currentPageURL.includes('/tags')) {
  lvl0Value = 'Tag';
} else {
  lvl0Value = 'jihoon.me';
}

docsearch({
    container: '#docsearch',
    appId: '3FO4WHQGGO',
    indexName: 'blog',
    apiKey: 'f45f471cd92d448f891637e486f50362',
    algoliaOptions: {
      facetFilters: [`lvl0:${lvl0Value}`],
    },
    debug: true
});
