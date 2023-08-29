//
// Filename: StoredAsyncImage.swift
// Project: DevAcademy
//
// Developer:
//  Name: Tomáš Tomala
//  Email: tomalatms@gmail.com
//
// Description:
//

import SwiftUI
import CryptoKit


private class ImageStorage {
    static let shared: ImageStorage = ImageStorage()

    /// Select an folder in this application bundle. We want ideally an "Application Support" directory. In this directory, we want to store our images in subdirectory called "imageCache",
    private let defaultPath: URL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
                                                            .first!.appendingPathComponent("imageCache")

    /// Initializer first checks, whether folder for `defaultPath` exists. If not, it creates a new one.
    init() {
        if (!FileManager.default.fileExists(atPath: defaultPath.path(percentEncoded: false))) {
            try! FileManager.default.createDirectory(at: defaultPath, withIntermediateDirectories: true)
        }
    }


    /// Takes an URL as a input and produces SHA256 String of the URL as the output.
    ///
    /// We don't use protocol `Hashable` from two reasons. Firstly, the Apple Documentation explicitly forbids to use `Hashable` and `hashValue` for any purpose related to persistence. The hashes are different at each execution for security reasons. Secondly, the 64-bit `Int` is just too short.
    ///
    /// - Parameter url: URL to be hashed
    /// - Returns: Hashed string
    private func hash(of url: URL) -> String {
        let path = url.description.data(using: .utf8)!
        return SHA256.hash(data: path).compactMap { String(format: "%02x", $0) }.joined()
    }


    /// Check, whether file is already cached and if so, returns an Image.
    ///
    /// The function should have following behavior:
    ///  - Hash the URL
    ///  - Check, whether file names by this hash already exists
    ///  - If so, load it and return it as an Image
    ///
    /// - Parameter url: The URL of the request that would be executed upon the server.
    /// - Returns: Image if exists.
    func loadImage(for url: URL) -> Image? {
        let hashedPath = hash(of: url)
        
        if (!FileManager.default.fileExists(atPath: hashedPath)) { return nil }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: hashedPath)) else { return nil }
        
        guard let img = UIImage(data: data) else { return nil }
        
        return Image(uiImage: img)
    }


    /// Updates image in the cache.
    ///
    /// The function should have following behavior:
    ///  - Hash the URL
    ///  - Remove existring file (if exists)
    ///  - Create a binary data from the image
    ///  - Save the binary data to the file
    ///
    /// - Parameters:
    ///   - image: Image to be stored
    ///   - url: The URL that was executed upon the server to get this image.
    func update(image: UIImage, at url: URL) {
        let hashedPath = hash(of: url)
        
        if (FileManager.default.fileExists(atPath: hashedPath)) {
            try? FileManager.default.removeItem(atPath: hashedPath)
        }
                
        guard let bytes = image.jpegData(compressionQuality: 1.0) else { return }
        
        try? bytes.write(to: URL(fileURLWithPath: hashedPath))
    }
}
