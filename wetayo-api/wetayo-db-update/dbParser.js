exports.dbParser = function (elements) {
  const parse = elements.split('^');
  const parseColumn = parse.shift().split('|');
  return parse.map((station) => {
    let data = station.split('|');
    let result = {};

    for (let i = 0; i < parseColumn.length; i++) {
      result[parseColumn[i]] = data[i];
    }
    return result;
  });
};
