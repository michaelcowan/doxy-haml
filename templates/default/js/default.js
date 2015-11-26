$(document).ready( function() {
  index = lunr(function () {
    this.field('name', {boost: 10})
    this.field('brief', {boost: 2})
    this.field('description')
    this.field('type')
    this.ref('id')
  });

  // TODO When hosted on a web server it would be better to load from search.json without usin JSONP
  // $.getJSON(search_json_url, function(json) {
  //   documents = json;
  // });
  var documents = lunrData['entries'];

  documents.forEach(function (document) {
    index.add(document);
  });

  $('.search-field').keyup(function(e) {
    if(e.which == 13) {
      return;
    }
    $('.search-results').empty();

    var query = $(this).val();
    if(query === '') {
      $('.search-results').hide();
    }
    else {
      $('.search-results').append($('<h2/>').html("Search Results"));
      var results = index.search(query);
      if(results.length == 0) {
        $('.search-results').append($('<p><strong>No results found</strong></p>'));
      }
      else {
        $('.search-results').append(results.map(function(result) {
          return $('<p/>').html($('<textarea/>').html(result.ref).text());
        }));
      }
      $('.search-results').show();
      $("html, body").animate({ scrollTop: 0 }, "slow");
    }
  });

  $('.search-field').keypress(function(e) {
    if(e.which == 13) {
      e.preventDefault();
      var first_hit = $(".search-results a:first");
      if(first_hit.length !== 0) {
        first_hit[0].click();
      }
    }
  });

});