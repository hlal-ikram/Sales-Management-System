class ClientsModel {
  String? nomc;
  int? clientID;

  ClientsModel({this.nomc, this.clientID});

  ClientsModel.fromJson(Map<String, dynamic> json) {
    nomc = json['nomc'];
    clientID = json['ClientID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nomc'] = nomc;
    data['ClientID'] = clientID;
    return data;
  }
}
