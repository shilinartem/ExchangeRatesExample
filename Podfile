# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'






project 'ExchangeRatesExample.xcodeproj'
	def shared_pods
	pod 'ReactiveCocoa', '~> 2.5'
	pod 'Objection'
	pod 'AFNetworking'
	pod 'Mantle'
end

target 'ExchangeRatesExample' do
	shared_pods
end

target 'ExchangeRatesExampleTests' do
    shared_pods
    pod 'Specta'
    pod 'Expecta'
    pod 'OCMockito'
end