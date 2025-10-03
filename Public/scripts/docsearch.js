document.addEventListener("DOMContentLoaded", function () {
  if (typeof docsearch !== "undefined") {
    docsearch({
      container: "#docsearch",
      appId: "3FO4WHQGGO",
      indexName: "blog",
      apiKey: "f45f471cd92d448f891637e486f50362",
      debug: true,
    });
  }
});
