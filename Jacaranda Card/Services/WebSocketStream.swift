//
//  WebSocketStream.swift
//  Jacaranda Card
//
//  Created by weng chong lao on 3/1/2023.
//

import Foundation

class WebSocketStream: AsyncSequence {

    typealias Element = URLSessionWebSocketTask.Message
    typealias AsyncIterator = AsyncThrowingStream<URLSessionWebSocketTask.Message, Error>.Iterator

    private var stream: AsyncThrowingStream<Element, Error>?
    private var continuation: AsyncThrowingStream<Element, Error>.Continuation?
    private let socket: URLSessionWebSocketTask

    
    init(url: String, session: URLSession = URLSession.shared) {
        socket = session.webSocketTask(with: URL(string: url)!)
        stream = AsyncThrowingStream { continuation in
            self.continuation = continuation
            self.continuation?.onTermination = { @Sendable [socket] _ in
                socket.cancel()
            }
        }
    }
    
    
    func makeAsyncIterator() -> AsyncIterator {
        guard let stream = stream else {
            fatalError("stream was not initialized")
        }
        
        let sendMessage = URLSessionWebSocketTask.Message.string("Hello WebSocket")
        socket.send(sendMessage) { error in
            if let error = error {
                print("WebSocket sending error: \(error)")
            }
        }
        print("Sending hello to WebSocket")
        
        socket.resume()
        listenForMessages()
        return stream.makeAsyncIterator()
    }

    
    private func listenForMessages() {
        socket.receive { [unowned self] result in
            switch result {
            case .success(let message):
                continuation?.yield(message)
                listenForMessages()
                
            case .failure(let error):
                continuation?.finish(throwing: error)
            }
        }
    }
}
