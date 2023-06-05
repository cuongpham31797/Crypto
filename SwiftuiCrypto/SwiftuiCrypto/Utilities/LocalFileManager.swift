//
//  LocalFileManager.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 25/05/2023.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let shared: LocalFileManager = LocalFileManager()
    private init() { }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        // create folder
        createFolderifNeeded(folderName: folderName)
        // get path to image
        guard let data = image.pngData(), let url = getURLForImage(imageName: imageName,
                                                                   folderName: folderName) else {
            return
        }
        
        do {
            try data.write(to: url)
        } catch {
            print("Error saving image: \(imageName) : Error \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        
        if #available(iOS 16.0, *) {
            guard let url = getURLForImage(imageName: imageName,
                                           folderName: folderName), FileManager.default.fileExists(atPath: url.path()) else {
                return nil
            }
            return UIImage(contentsOfFile: url.path())
        } else {
            guard let url = getURLForImage(imageName: imageName,
                                           folderName: folderName), FileManager.default.fileExists(atPath: url.path) else {
                return nil
            }
            return UIImage(contentsOfFile: url.path)
        }
        
    }
    
    private func createFolderifNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else {
            return
        }
        if #available(iOS 16.0, *) {
            if !FileManager.default.fileExists(atPath: url.path()) {
                do {
                    try FileManager.default.createDirectory(at: url,
                                                            withIntermediateDirectories: true)
                } catch let error {
                    print("Error creating file \(error)")
                }
            }
        } else {
            if !FileManager.default.fileExists(atPath: url.path) {
                do {
                    try FileManager.default.createDirectory(at: url,
                                                            withIntermediateDirectories: true)
                } catch let error {
                    print("Error creating file \(error)")
                }
            }
        }
        
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory,
                                                 in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
