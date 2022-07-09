abstract class APIDecode<T> {
	T decode(dynamic json);
}

class APITypeDecodable<T> implements APIDecode<APITypeDecodable<T>> {
	T? value;
	APITypeDecodable({this.value});

	@override
	APITypeDecodable<T> decode(dynamic json) {
		value = json;
		return this;
	}
}