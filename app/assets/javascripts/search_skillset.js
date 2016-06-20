var skillsets = new Bloodhound({
datumTokenizer: function(datum) {
  return Bloodhound.tokenizers.whitespace(datum.value);
},
queryTokenizer: Bloodhound.tokenizers.whitespace,
remote: {
  wildcard: "%QUERY",
  url: '/search/skillset/%QUERY',
  transform: function(response) {
    // Map the remote source JSON array to a JavaScript object array
    return $.map(response, function(skillset) {
      return {
        value: skillset.name
      };
    });
  }
}
});

  $('.typeahead').materialtags({
      typeaheadjs: {
          // name: 'skillsets',
          // displayKey: 'value',
          // valueKey: 'value',
          // source: skillsets
          name: 'skillsets',
          display: 'value',
          source: skillsets.ttAdapter()
      }
  });
  // $('.typeahead').typeahead(null, {
  //   display: 'value',
  //   source: skillsets
  // });
