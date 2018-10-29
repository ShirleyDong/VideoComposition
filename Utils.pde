void printKeyColours(color [] kC) {
  for (color c : kC) {
    print("(" + red(c) + ", " + green(c) + ", " + blue(c) + "), ");
  }
  println();
}


void saveKeyData(String fName) {
  JSONObject data = new JSONObject();
  
  data.setString("clip", movieFilename);
  data.setFloat("closeColourValue", closeColourDistance);
  data.setBoolean("blur", blur);
  data.setJSONArray("keyColours", makeJSONArray(keyColours));
  
  saveJSONObject(data, fName);
}

JSONArray makeJSONArray(color [] c) {
  JSONArray a = new JSONArray();
  
  for (int i = 0; i < c.length; i += 1) {
    a.setInt(i, c[i]);
  }
  
  return a;
}